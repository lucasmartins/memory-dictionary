require "spec_helper"

describe MemoryDictionary, "::version" do
  it "returns a valid version" do
    version = MemoryDictionary::Version::STRING
    expect(version.split('.').size).to be >= 3
  end
end