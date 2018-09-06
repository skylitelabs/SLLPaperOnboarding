Pod::Spec.new do |s|
  s.name         = 'SLLPaperOnboarding'
  s.version      = '0.0.1'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'Leejay Schmidt' => 'leejay.schmidt@skylite.io' }
  s.summary      = 'Simple, beautiful onboarding for iOS written in Objective C'
  s.homepage     = 'https://github.com/skylitelabs/SLLPaperOnboarding'

# Source Info
  s.platform     = :ios, '8.0'
  s.source       = { :git => 'https://github.com/skylitelabs/SLLPaperOnboarding.git', :tag => "0.0.1" }
  s.source_files = 'Source/SLLPaperOnboarding.{h, m}', 'Source/SLLOnboardingItemInfo.{h, m}', 'Source/PageView/SLLPageView.{h, m}', 'Source/PageView/PageContainerView/SLLPageContainer.{h, m}', 'Source/PageView/Item/SLLPageViewItem.{h, m}', 'Source/OnboardingContentView/SLLOnboardingContentView.{h, m}', 'Source/OnboardingContentView/Item/SLLOnboardingContentViewItem.{h, m}', 'Source/GestureControl/SLLGestureControl.{h, m}', 'Source/FillAnimationView/SLLFillAnimationView.{h, m}'
  s.requires_arc = true
end
