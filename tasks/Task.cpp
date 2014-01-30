/* Generated from orogen/lib/orogen/templates/tasks/Task.cpp */

#include "Task.hpp"
#include "pressure_paroscientific/Driver.hpp"

using namespace pressure_paroscientific;

Task::Task(std::string const& name)
    : TaskBase(name),
      mDriver(0)
{
}

Task::Task(std::string const& name, RTT::ExecutionEngine* engine)
    : TaskBase(name, engine),
      mDriver(0)
{
}

Task::~Task()
{
	delete mDriver;
}



/// The following lines are template definitions for the various state machine
// hooks defined by Orocos::RTT. See Task.hpp for more detailed
// documentation about them.

bool Task::configureHook()
{
    delete mDriver;
    mDriver = new pressure_paroscientific::Driver;
    if (!_io_port.get().empty())
    {
        mDriver->open(_io_port.get());
        std::cout<<"open-uri ok "<<std::endl;
    }

    setDriver(mDriver);

    if (! TaskBase::configureHook())
        return false;
    return true;
}


bool Task::startHook()
{
    if (! TaskBase::startHook())
        return false;
    return true;
}


void Task::processIO()
{
    mDriver->collectPeriodicData();

    _paro_samples.write(mDriver->getData());

}


//void Task::updateHook()
//{
//    TaskBase::updateHook();
//}


// void Task::errorHook()
// {
//     TaskBase::errorHook();
// }


//void Task::stopHook()
//{
//    TaskBase::stopHook();
//}


// void Task::cleanupHook()
// {
//     TaskBase::cleanupHook();
// }

