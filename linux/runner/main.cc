#include "openjournal_app.h"

int main(int argc, char** argv) {
  g_autoptr(OpenJournalApplication) app = openjournal_app_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}
