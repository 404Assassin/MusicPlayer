////////////////////////////////////////////////////////////////////////////////
//
//  Christian Worley Development & Design
//  Copyright 2011 CW D&D
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////
package com.cw.control.observer{
	/**
	 * ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * Invoked Observer Interface implemented by classes useing InvokedObserver.
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: Christian Worley
	 * created: 09/2011
	 * TODO: create an extendable Observer
	 * ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	public interface IInvokedObserver{
		function observableInstanceRef(observableRef:InvokedObserver):void;
		function update(theObserver:InvokedObserver, infoObject:Object):void;
	}
}