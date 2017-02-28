require "spec_helper"

describe Sinatra::Rider do
  it "has a version number" do
    expect(Sinatra::Rider::VERSION).not_to be nil
  end

  context 'When registering with Sinatra' do
    it 'sets the database file' do
      server = TestServer.new
      expect(server.settings.database_file).to match('config/database.yml')
    end
  end
end
