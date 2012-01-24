////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright 2012 Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package com.cw.view {
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * class description: ProgressIndicator
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: christian
	 * created: Jan 23, 2012
	 * TODO:
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import com.cw.control.observer.ISubject;
	import com.cw.view.shapeCreators.CreateShape;
	import com.greensock.TimelineLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import flash.display.Sprite;

	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class ProgressIndicator implements ISubject {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var progressBarHolder:Sprite;
		private var progressBar:Sprite;
		private var observer:ISubject;
		private var currentTrack:String;
		private var currentTrackLoader:MP3Loader;
		private var currentPosition:String;
		private var myTimeline:TimelineLite;
		private var theStateOfPlay:Boolean;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function ProgressIndicator () {}
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
			if(infoObject.substring(0, 5) == 'track') {
				this.currentTrack = infoObject;
			}
			if(hasOwnProperty(infoObject)) {
				this[infoObject]();
			}
		}
		public function getCurrentTrack ():String {
			notifyObservers(currentTrack);
			return currentTrack
		}
		public function thePlayStateOn ():void {
			if(!theStateOfPlay) {
				theStateOfPlay = true;
				progressHandler();
			}
		}
		public function thePauseStateOn ():void {
			theStateOfPlay = false
			myTimeline.pause();
		}
		public function theStopState ():void {
			theStateOfPlay = false
			/*myTimeline.append(new */TweenMax.to(progressBarHolder, .2, {alpha:.25, scaleX:0, ease:Linear});
			myTimeline.stop();
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private function addProgressBar ():void {
			progressBarHolder = new Sprite();
			progressBar = new Sprite();
			var theShapeCreator:CreateShape = new CreateShape();
			theShapeCreator.draw(CreateShape.SQUARE_FILLED, progressBar, 0, 0, 300, 20)
			progressBarHolder.addChild(progressBar);
		}
		private function progressHandler ():void {
			var currentTrackLoader:MP3Loader = LoaderMax.getLoader(currentTrack);
			var theProgressNumber:Number = currentTrackLoader.playProgress;
			trace(" ::::::::::: ProgressIndicator.progressHandler(progressAmount) " + theProgressNumber);
			myTimeline = new TimelineLite({onComplete:progressHandler});
			myTimeline.append(new TweenMax(progressBarHolder, .2, {alpha:.25, scaleX:theProgressNumber, ease:Linear}));
		}
	}
}
