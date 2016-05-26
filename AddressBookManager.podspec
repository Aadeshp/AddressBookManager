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
  s.version          = "0.1.7"
  s.summary          = "Swift Wrapper Class Of Apple's AddressBook Framework"
  s.description      = <<-DESC
                       Swift Wrapper Class Of Apple's AddressBook Framework

                       Simplifies:
                       * Retrieving contacts
                       * Retrieving specific contact data
                       * Adding contacts
                       DESC
  s.homepage         = "https://github.com/aadeshp/AddressBookManager"

  s.license          = 'MIT'
  s.author           = { "aadesh" => "aadeshp95@gmail.com" }
  s.source           = { :git => "https://github.com/aadeshp/AddressBookManager.git", :tag => "v" + s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
end
