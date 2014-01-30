#! /usr/bin/env ruby
require 'orocos'
#include Orocos

## Initialize orocos for sim_quest3D##
Orocos.initialize

## Execute the task 'imu_microstrain::Task' ##
Orocos.run 'pressure_paroscientific::Task' => 'pressure_paroscientific' do
Orocos.logger.level = Logger::DEBUG;

puts "deployed pressure_paroscientific::Task"

pressure_paroscientific = Orocos::TaskContext.get 'pressure_paroscientific'

Orocos.apply_conf(pressure_paroscientific, 'pressure_paroscientific::Task.yml')

pressure_paroscientific.configure
pressure_paroscientific.start


        while true
        #   if msg = reader.read_new
        #      puts "#{msg.time} #{msg.content}"
        #   end
        #
            sleep 0.1

        end
end
