////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright ${date} Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package com.cw.control.observer{
	/**
	 * ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * interface description: ISubject
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0 
	 * author: christian
	 * created: Dec 26, 2011
	 * TODO:
	 * ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Interface characteristics
	//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public interface ISubject{
		//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		/**
		 * add an observer refrence to InvokedObserver
		 */
		function addObserver(observer:ISubject):void
		/**
		 * remove an observer refrence from InvokedObserver
		 */
		function removeObserver(observer:ISubject):void
		/**
		 * notify the InvokedObserver observers of an update
		 */
		function notifyObservers(infoObject:String):void
	}
}