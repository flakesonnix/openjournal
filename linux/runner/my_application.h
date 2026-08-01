#ifndef FLUTTER_MY_APPLICATION_H_
#define FLUTTER_MY_APPLICATION_H_

#include <adwaita.h>

G_DECLARE_FINAL_TYPE(MyApplication,
                     my_application,
                     MY,
                     APPLICATION,
                     AdwApplication)

MyApplication* my_application_new();

#endif  // FLUTTER_MY_APPLICATION_H_
