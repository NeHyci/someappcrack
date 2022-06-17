#import <Foundation/Foundation.h>

%hook CLInAppPurchaseFeatureManager
- (bool)isUnlockedForFeature:(id)a1 {
	return true;
}
%end
%hook CLInAppPurchaseProduct
- (bool)isActive {
	return true;
}
%end

%ctor {
	@autoreleasepool {
		if ([NSBundle.mainBundle.bundleIdentifier hasPrefix:@"com.chii"]) { // 这个公司的软件很多，懒得一个个往plist里写
			%init;
		}
	}
}
