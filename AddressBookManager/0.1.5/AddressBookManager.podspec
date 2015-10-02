#
# Be sure to run `pod lib lint AddressBookManager.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "AddressBookManager"
  s.version          = "0.1.5"
  s.summary          = "Swift Wrapper Class Of Apple's AddressBook Framework"
  s.description      = <<-DESC
                       Swift Wrapper Class Of Apple's AddressBook Framework

                       Easy Usage To:
                       * Retrieve Contacts
                       * Add Contacts
                       DESC
  s.homepage         = "https://github.com/aadeshp/AddressBookManager"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "aadesh" => "aadeshp95@gmail.com" }
  s.source           = { :git => "https://github.com/aadeshp/AddressBookManager.git", :tag => "v" + s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  # s.resource_bundles = {
  #  'AddressBookManager' => ['Pod/Assets/*.png']
  #  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
