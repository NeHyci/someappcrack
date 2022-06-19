#include <mach-o/dyld.h>
#include <substrate.h>
#include <dlfcn.h>

static bool NodeVideo$$IAPManager$$IsPro(void) {
	return true;
}

static intptr_t getUnityFrameworkVmaddrSlide(void) {
	@autoreleasepool {
		dlopen([NSString stringWithFormat:@"%@/Frameworks/UnityFramework.framework/UnityFramework", NSBundle.mainBundle.bundlePath].UTF8String, RTLD_LAZY);
		// UnityFramework不是通过Load Command加载，而是在主程序中手动加载，所以如果我们需要hook其中的函数，需要在插件里先dlopen
	}
	intptr_t slide = 0;
	uint32_t count = _dyld_image_count();
	for (uint32_t i = 0; i < count; i++) {
		const char *name = _dyld_get_image_name(i);
		if (strstr(name, "UnityFramework.framework")) {
			slide = _dyld_get_image_vmaddr_slide(i);
			break;
		}
	}
	return slide;
}

%ctor {
	// bool __cdecl NodeVideo_IAPManager__IsPro(NodeVideo_IAPManager_o *this, const MethodInfo *method)
	// In v4.3.19, the address of theis function is 0x1C19FB8.
	// This app is based on Unity, you can find the function via il2cppdumper for other version.
	MSHookFunction((void *)(getUnityFrameworkVmaddrSlide() + 0x1C19FB8), (void *)NodeVideo$$IAPManager$$IsPro, NULL);
}
