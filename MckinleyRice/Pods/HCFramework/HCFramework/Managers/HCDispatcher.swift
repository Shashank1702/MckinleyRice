//
//  HCDispatcher.swift
//
//  Created by Hypercube on 6/12/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import Foundation


/// HCDispatcher class which handles number of tasks which are in progress in order to perform some operation when all tasks are finished.
open class HCDispatcher: NSObject {

    /// Number of tasks which are in progress.
    public var tasksToFinish: Int = 0
    
    /// Completion handler, i.e. operation which has to be performed when all tasks are finished (when tasksToFinish = 0)
    public var completionHandler: () -> Void = {}

    /// Method for setting completion handler.
    ///
    /// - Parameter handler: Operation which has to be performed when all tasks are finished.
    public func setCompletitionHandler(handler: @escaping () -> Void)
    {
        completionHandler = handler
    }
    
    /// Signal that a task has started.
    public func startTask()
    {
        tasksToFinish += 1
    }
    
    /// Signal that a task is done and to check if all tasks are done.
    public func endTask()
    {
        tasksToFinish -= 1
        
        checkIfAllTasksDone()
    }
    
    /// Check if all tasks are done. If it is true, then completion handler is performed.
    public func checkIfAllTasksDone()
    {
        if tasksToFinish == 0
        {
            completionHandler()
        } else if tasksToFinish < 0
        {
            print("***************************************************************** tasksToFinish NEGATIVE *****************************************************************")
        }
    }
}
