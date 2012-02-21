////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright 2012 Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package com.cw.view.preloaders {
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * class description: OneBarPreloader
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: christian
	 * created: Jan 19, 2012
	 * TODO:
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import com.cw.control.observer.ISubject;
	import com.cw.view.shapeCreators.CreateShape;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Sine;
	import com.greensock.events.LoaderEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class OneBarPreloader implements ISubject {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var progressBarHolder:Sprite;
		private var progressBar:Sprite;
		private var observer:ISubject;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function OneBarPreloader () {}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function initProgressBar ():void {
			addProgressBar();
		}
		public function getProgressBar ():Sprite {
			return progressBarHolder;
		}
		/**
		 * InvokedObserver interface, reference update, and subscription with
		 * updated observer and adding subscription with addObserver(this).
		 */
		public function addObserver (observer:ISubject):void {
			this.observer = observer;
			observer.addObserver(this);
		}
		/**
		 * InvokedObserver notification
		 */
		public function notifyObservers (infoObject:String):void {
			observer.notifyObservers(infoObject);
		}
		/**
		 * remove an observer refrence from InvokedObserver
		 */
		public function removeObserver (observer:ISubject):void {
			this.observer = observer;
			observer.removeObserver(this);
		}
		public function update (infoObject:String):void {
			if(infoObject.substring(0, 13) == 'childProgress') {
				progressHandler(infoObject);
			}
			if(hasOwnProperty(infoObject)){
				this[infoObject]();
			}
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function addProgressBar ():void {
			progressBarHolder = new Sprite();
			progressBar = new Sprite();
			TweenMax.to(progressBar, 0, {alpha:0, scaleX:0});
			var theShapeCreator:CreateShape = new CreateShape();
			theShapeCreator.draw(CreateShape.SQUARE_FILLED, progressBar, 0, 0, 300, 20);
			progressBarHolder.addChild(progressBar);
		}
		private function progressHandler (progressAmount:String):void {
			var theProgressNumber:Number = Number(progressAmount.slice(14, progressAmount.length));
			TweenMax.to(progressBar, .2, {alpha:.15, scaleX:theProgressNumber, ease:Linear});
		}
	}
}
