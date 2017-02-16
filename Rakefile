require 'rake/clean'

src=["main.go","setup.go","execute.go"]

file "pkgbrew" => src do
	revision=`git rev-parse --verify HEAD`
	sh "go build -o pkgbrew -ldflags '-X main.revision=#{revision}'"
end

file "trunk.tar.gz" do
	sh "wget https://github.com/jsonn/pkgsrc/archive/trunk.tar.gz"
end

task :format => src do
	src.each do |f|
		sh "gofmt -w #{f}"
	end
end

task :commit => :format do
	sh "git commit -a"
end

task :test => "trunk.tar.gz" do
	sh "go test"
end

namespace :docker do
	task :build do
		sh "docker build -t pkgbrew ."
	end
	task :run => [:build, "trunk.tar.gz"] do
		sh "docker run --rm pkgbrew"
	end
	task :test => :run
end

task :default => "pkgbrew"
