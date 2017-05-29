require "dockerspec/serverspec"

Docker.options[:read_timeout] = 900
BOINC_PORT = 31416

describe "Dockerfile" do

  describe docker_build(path: '.', tag: 'boinc') do
    it { should have_label 'MAINTAINER' => 'Bradley Leonard <bradley@stygianresearch.com>' }
    it { should have_label 'description' => 'This container will run the boinc-client.' }
    it { should have_expose '31416' }
    it { should have_user 'boinc' }
    it { should have_workdir '/var/lib/boinc' }
    it { should have_cmd "/scripts/startup.sh"}

    describe docker_run('boinc', family: :debian) do
      describe 'boinc-client' do
        describe package('boinc-client') do
          it { should be_installed }
        end
      end
    end
  end
end
#  before(:all) do
#    @image = Docker::Image.build_from_dir('.', {'networkmode' => 'host'})
#
#    set :os, family: :fedora
#    set :backend, :docker
#    set :docker_image, @image.id
#  end


#  it "installs the right version of fedora" do
#    expect(os_version).to include("Fedora release 25")
#  end

#  describe package("boinc-client") do
#    it { should be_installed.with_version('7.6.22') }
#  end

#  describe file('/scripts/startup.sh') do
#    it { should be_mode 755 }
#  end

#  describe 'Dockerfile#config' do

#    it 'should expose the boinc management port' do
#       expect(@image.json['ContainerConfig']['ExposedPorts']).to include("#{BOINC_PORT}/tcp")
#    end
#
#  end


#  possible tests for Dockerfile
#  describe 'Dockerfile#config' do
#    it 'should expose the calibre port' do
#      expect(@image.json['ContainerConfig']['ExposedPorts']).to include("#{CALIBRE_PORT}/tcp")
#    end
#  end
#
#  describe package("calibre") do
#    it { should be_installed.with_version('2.69.0') }
#  end
#
#  describe file('/data') do
#    it { should be_directory }
#  end
#

#  possible tests for running container
#  describe 'Dockerfile#running' do
#    before (:all) do
#      @container = Docker::Container.create(
#        'Image' => @image.id,
#        'HostConfig' => {
#          'Binds' => ['/tmp/data:/data'],
#          'PortBindings' => { "#{CALIBRE_PORT}/tcp" => [{ 'HostPort' => "#{CALIBRE_PORT}" }] }
#        }
#      )
#
#      @container.start('Binds' => ['/home/bradley/calibre/data:/data:Z'])
#    end
#
#    describe file('/data/library') do
#      it { should be_directory }
#    end
#
#    describe "running calibre server" do
#
#      describe command('/usr/bin/netstat -tunl | /usr/bin/grep 8080') do
#        its(:exit_status) { should eq 0 }
#      end
#
#      describe command('/usr/bin/ps -eaf | /usr/bin/grep calibre-server') do
#        its(:exit_status) { should eq 0 }
#      end
#
#    end
#
#    after(:all) do
#      @container.kill
#      @container.delete(:force => true)
#    end
#
#  end

#end
