#
# Be sure to run `pod spec lint Parse-RACExtensions.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://docs.cocoapods.org/specification.html
#
Pod::Spec.new do |s|
  s.name         = "Parse-RACExtensions"
  s.version      = "1.0.0"
  s.summary      = "ReactiveCocoa extensions for Parse."
  s.homepage     = "https://github.com/kastiglione/Parse-RACExtensions"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author       = { "Dave Lee" => "dave@kastiglione.com" }
  s.source       = { :git => "https://github.com/kastiglione/Parse-RACExtensions.git", :tag => "1.0.0" }
  s.platform     = :ios, '5.0'
  s.source_files = 'Parse-RACExtensions'
  s.requires_arc = true
  s.dependency 'Parse', '~> 1.2.10'
  s.dependency 'ReactiveCocoa', '~> 1.9.6'
  s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '"${PODS_ROOT}/Parse"' }
end
