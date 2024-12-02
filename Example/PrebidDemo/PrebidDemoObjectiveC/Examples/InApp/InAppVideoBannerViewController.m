/*   Copyright 2019-2022 Prebid.org, Inc.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "InAppVideoBannerViewController.h"
#import "PrebidDemoMacros.h"

NSString * const storedImpVideoBannerInApp = @"prebid-demo-video-outstream";

@interface InAppVideoBannerViewController ()

// Prebid
@property (nonatomic) PBBannerView * prebidBannerView;

@end

@implementation InAppVideoBannerViewController

- (void)loadView {
    [super loadView];
    
    [self createAd];
}

- (void)createAd {
    // 1. Create a PBBannerView
    self.prebidBannerView = [[PBBannerView alloc] initWithFrame:CGRectMake(0, 0, self.adSize.width, self.adSize.height) configID:storedImpVideoBannerInApp adSize:self.adSize];
    
    // 2. Configure the PBBannerView
    self.prebidBannerView.delegate = self;
    self.prebidBannerView.adFormat = AdFormat.video;
    self.prebidBannerView.videoParameters.placement = PBPlacement.InBanner;
    
    // Add Prebid banner view to the app UI
    self.bannerView.backgroundColor = [UIColor clearColor];
    [self.bannerView addSubview:self.prebidBannerView];
    
    // 3. Load the banner ad
    [self.prebidBannerView loadAd];
}

// MARK: - BannerViewDelegate

- (UIViewController *)bannerViewPresentationController {
    return self;
}

- (void)bannerView:(PBBannerView *)bannerView didFailToReceiveAdWith:(NSError *)error {
    PBMLogError(@"%@", error.localizedDescription);
}

@end
