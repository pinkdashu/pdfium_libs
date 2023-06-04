#include"fpdfview.h"

#if _WIN32
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif
FFI_PLUGIN_EXPORT intptr_t NullToDo() { 
    FPDF_InitLibrary();
    return 0; }