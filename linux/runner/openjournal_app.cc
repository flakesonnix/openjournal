#include "openjournal_app.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>

#include "flutter/generated_plugin_registrant.h"

struct _OpenJournalApplication {
  GtkApplication parent_instance;
  char** dart_entrypoint_arguments;
};

G_DEFINE_TYPE(OpenJournalApplication, openjournal_app, GTK_TYPE_APPLICATION)

static FlMethodResponse* handle_open_url(FlMethodChannel* channel,
                                        FlValue* args) {
  if (fl_value_get_type(args) != FL_VALUE_TYPE_MAP) {
    return FL_METHOD_RESPONSE(fl_method_error_response_new(
        "Bad Arguments", "Expected map", nullptr));
  }

  FlValue* url_value = fl_value_lookup_string(args, "url");
  if (fl_value_get_type(url_value) != FL_VALUE_TYPE_STRING) {
    return FL_METHOD_RESPONSE(fl_method_error_response_new(
        "Bad Arguments", "Expected string 'url'", nullptr));
  }

  const gchar* url = fl_value_get_string(url_value);

  // GTK4: gtk_show_uri
  gtk_show_uri(nullptr, url, GDK_CURRENT_TIME);

  return FL_METHOD_RESPONSE(fl_method_success_response_new(nullptr));
}

static void method_call_cb(FlMethodChannel* channel,
                           FlMethodCall* method_call,
                           gpointer user_data) {
  const gchar* method = fl_method_call_get_name(method_call);
  FlValue* args = fl_method_call_get_args(method_call);

  g_autoptr(FlMethodResponse) response = nullptr;
  if (g_strcmp0(method, "open_url") == 0) {
    response = handle_open_url(channel, args);
  } else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  g_autoptr(GError) error = nullptr;
  if (!fl_method_call_respond(method_call, response, &error)) {
    g_warning("Failed to send method call response: %s", error->message);
  }
}

static void openjournal_app_activate(GApplication* application) {
  OpenJournalApplication* self = OPENJOURNAL_APP(application);

  GtkWindow* window = GTK_WINDOW(gtk_application_window_new(GTK_APPLICATION(application)));
  gtk_window_set_title(window, "OpenJournal");
  gtk_window_set_default_size(window, 1280, 720);

  g_autoptr(FlDartProject) project = fl_dart_project_new();
  fl_dart_project_set_dart_entrypoint_arguments(project, self->dart_entrypoint_arguments);

  FlView* view = fl_view_new(project);

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  FlMethodChannel* channel = fl_method_channel_new(fl_view_get_engine(view),
                                                   "org.openpsychonaut.openjournal/launcher",
                                                   FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(channel, method_call_cb, self, nullptr);

  gtk_window_set_child(window, GTK_WIDGET(view));

  fl_register_plugins(FL_PLUGIN_REGISTRY(view));

  gtk_window_present(window);
}

static gboolean openjournal_app_local_command_line(GApplication* application,
                                                  gchar*** arguments,
                                                  int* exit_status) {
  OpenJournalApplication* self = OPENJOURNAL_APP(application);
  self->dart_entrypoint_arguments = g_strdupv(*arguments + 1);

  g_autoptr(GError) error = nullptr;
  if (!g_application_register(application, nullptr, &error)) {
    g_warning("Failed to register: %s", error->message);
    *exit_status = 1;
    return TRUE;
  }

  g_application_activate(application);
  *exit_status = 0;

  return TRUE;
}

static void openjournal_app_dispose(GObject* object) {
  OpenJournalApplication* self = OPENJOURNAL_APP(object);
  g_clear_pointer(&self->dart_entrypoint_arguments, g_strfreev);
  G_OBJECT_CLASS(openjournal_app_parent_class)->dispose(object);
}

static void openjournal_app_class_init(OpenJournalApplicationClass* klass) {
  G_APPLICATION_CLASS(klass)->activate = openjournal_app_activate;
  G_APPLICATION_CLASS(klass)->local_command_line = openjournal_app_local_command_line;
  G_OBJECT_CLASS(klass)->dispose = openjournal_app_dispose;
}

static void openjournal_app_init(OpenJournalApplication* self) {}

OpenJournalApplication* openjournal_app_new() {
  g_set_prgname(APPLICATION_ID);

  return OPENJOURNAL_APP(g_object_new(openjournal_app_get_type(),
                                     "application-id", APPLICATION_ID, "flags",
                                     G_APPLICATION_NON_UNIQUE, nullptr));
}
