#! /usr/bin/env ruby
#
require 'orocos'
require 'optparse'
Orocos.initialize

gui = false
optparse = OptionParser.new do |opt|
    opt.banner = "run [--gui] DEVICE"
    opt.on '--gui', "starts the Rock task inspection widget on the running task" do
        gui = true
    end
end
io_port = *optparse.parse(ARGV)
if !io_port
    puts optparse
    exit 1
end

if gui
    require 'vizkit'
end

Orocos.run 'pressure_paroscientific::Task' => 'paro' do
    Orocos.logger.level = Logger::DEBUG
    puts "deployed the pressure_paroscientific::Task task"

    paro = Orocos::TaskContext.get 'paro'
    paro.io_port = io_port
    paro.configure
    paro.start

    if gui
        task_inspector = Vizkit.default_loader.task_inspector
        task_inspector.config(paro)
        task_inspector.show
        Vizkit.exec
    else
        reader = paro.paro_samples.reader
        Orocos.watch(paro) do
            if sample = reader.read
                pp sample
            end
        end
    end
end

