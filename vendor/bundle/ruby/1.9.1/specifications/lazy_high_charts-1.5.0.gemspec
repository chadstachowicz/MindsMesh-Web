# -*- encoding: utf-8 -*-
# stub: lazy_high_charts 1.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "lazy_high_charts"
  s.version = "1.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3") if s.respond_to? :required_rubygems_version=
  s.authors = ["Miguel Michelson", "Deshi Xiao"]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDaDCCAlCgAwIBAgIBATANBgkqhkiG9w0BAQUFADA9MQ8wDQYDVQQDDAZ4aWFv\nZHMxFTATBgoJkiaJk/IsZAEZFgVnbWFpbDETMBEGCgmSJomT8ixkARkWA2NvbTAe\nFw0xMzA0MDYxMzI3MDdaFw0xNDA0MDYxMzI3MDdaMD0xDzANBgNVBAMMBnhpYW9k\nczEVMBMGCgmSJomT8ixkARkWBWdtYWlsMRMwEQYKCZImiZPyLGQBGRYDY29tMIIB\nIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAstLQxwnMJQS3rTiR/ee0qvoY\nnj7/iUPPQolYhGv6oyelLMujEe8aK5Q6iRROT7qaWSgT6B0Ey5Vcgd9kUIYPNO8j\ni4auNf4k43rH6cS3u663Z4qGzQA2LY8EREP6qd20xKkLKOZZaq4Zs+kAiFJoeA1x\nHbT++I3w2ASEji51bCvC+5DxtmiXiKxRgdpYYTV58U4COoI6E0Z5Wsg/76Dh1HNS\nbJJ/ot1U0mFH8L5WiOlNilOKMQYeuw341eQKC6JC1RndBGNuycsP6nQdnG9TcEpN\n24AlBqhgkARop1AFABNHSRdKVMwLBsdMHR3qCt6h3rV8lxsKAp8OzMdfLGmZ0wID\nAQABo3MwcTAJBgNVHRMEAjAAMAsGA1UdDwQEAwIEsDAdBgNVHQ4EFgQU/EnzZSv7\nevpAWbZdt2fXK41FQKUwGwYDVR0RBBQwEoEQeGlhb2RzQGdtYWlsLmNvbTAbBgNV\nHRIEFDASgRB4aWFvZHNAZ21haWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQBtCwhl\nc4Ygc8U0hGQLS6pTQQiMtbx3GO8VQ3UnqqNKaYbooaDZyNr6n1fPxNNrN/6vL/n1\nfPq82REG8ZQG8cWNn6cFf6bVOqxfVQsw6EJUFP43Dsgu/UZtqDJOgg2mFk+s8MKu\nj3Y295WKZ/hKIcv7mFzgA1EYcMaVDAyTmHZO97wwf+ONaQXOtxNshXu6Q9vLklqt\nmmxyweyNaHMTA6K8Kgphf6ZrP8fgJF0reyYqtSFczU1/e7z0hGtqxVQXhDmGFlyi\nPFrqtavP93jJrZtZ0zjekISXXKU2nvWYyZtmLfbO9Knv1UpytCIc4sx5Cm/JYAvw\nQ1Fsa+fmPQQ6IKKa\n-----END CERTIFICATE-----\n"]
  s.date = "2013-10-19"
  s.description = "    lazy_high_charts is leading edge rubyist render charts gem for displaying Highcharts graphs.\n"
  s.email = ["miguelmichelson@gmail.com", "xiaods@gmail.com"]
  s.extra_rdoc_files = ["README.md", "CHANGELOG.md"]
  s.files = ["README.md", "CHANGELOG.md"]
  s.homepage = "https://github.com/michelson/lazy_high_charts"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.11"
  s.summary = "rubyist way to render variant chart by highcharts without write javascript right now, rails gem library."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bundler>, [">= 1.0"])
      s.add_runtime_dependency(%q<hash-deep-merge>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, [">= 1.0"])
      s.add_dependency(%q<hash-deep-merge>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, [">= 1.0"])
    s.add_dependency(%q<hash-deep-merge>, [">= 0"])
  end
end
