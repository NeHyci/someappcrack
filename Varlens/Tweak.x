#include <substrate.h>

static int hook_int(void) {
    return 1;
}

%ctor {
    unsigned long long Varlens$AccountModel = (unsigned long)objc_getClass("Varlens.AccountModel"); // get address of _OBJC_CLASS_$__TtC7Varlens12AccountModel
    MSHookFunction((void *)*(unsigned long *)(Varlens$AccountModel + 0x1D8), (void *)hook_int, NULL); // unlock pro
    MSHookFunction((void *)*(unsigned long *)(Varlens$AccountModel + 0x1E8), (void *)hook_int, NULL); // unlock 2045 pro
}
