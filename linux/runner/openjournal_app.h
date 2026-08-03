#ifndef OPENJOURNAL_APP_H_
#define OPENJOURNAL_APP_H_

#include <gtk/gtk.h>

G_DECLARE_FINAL_TYPE(OpenJournalApplication,
                     openjournal_app,
                     OPENJOURNAL,
                     APPLICATION,
                     GtkApplication)

/**
 * openjournal_app_new:
 *
 * Creates a new Flutter-based application.
 *
 * Returns: a new #OpenJournalApplication.
 */
OpenJournalApplication* openjournal_app_new();

#endif  // OPENJOURNAL_APP_H_
