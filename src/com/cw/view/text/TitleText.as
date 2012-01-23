////////////////////////////////////////////////////////////////////////////////
//  Christian Worley Development & Design
//  Copyright 2012 Christian Worley Development & Design
//  All Rights Reserved.
////////////////////////////////////////////////////////////////////////////////
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Package Declaration
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package com.cw.view.text {
	/**
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 * class description: TitleText
	 * language version: ActionScript 3.0
	 * player version: Flash 10.0
	 * author: christian
	 * created: Jan 21, 2012
	 * TODO:
	 * :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	 */
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Imports
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	import com.cw.control.observer.ISubject;
	import com.cw.model.MusicPlayerState;
	import com.cw.view.text.CDynamicTextField;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import com.greensock.TweenMax;
	import flash.display.Sprite;

	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	// Class characteristics
	//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	public class TitleText implements ISubject {
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Variables
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		private var observer:ISubject;
		private var theCDynamicTextField:CDynamicTextField;
		private var theTitleTextHolder:Sprite;
		private var theTextField:Sprite;
		private var currentTrack:String;
		private var currentTrackLoader:MP3Loader;
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Constructor
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function TitleText () {}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Public Interfaces
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		public function initTheTitleText ():void {
			theCDynamicTextField = new CDynamicTextField();
			theTitleTextHolder = new Sprite();
			theTextField = new Sprite();
			titleText();
		}
		public function getTheTitleText ():Sprite {
			return theTitleTextHolder;
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
//			observer.notifyObservers();
		}
		/**
		 * remove an observer refrence from InvokedObserver
		 */
		public function removeObserver (observer:ISubject):void {
			this.observer = observer;
			observer.removeObserver(this);
		}
		public function update (infoObject:String):void {
			try {
				if(infoObject.substring(0, 5) == 'track') {
					theTitleText(infoObject);
				}
				this[infoObject]();
			} catch(error:Error) {
				//trace(" ::::::::::: skip non methods!!!!! ");
			}
		}
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// Private Methods
		//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		/**
		 * Method for creating and returning the mp3 title text field.
		 */
		private function titleText ():void {
			theCDynamicTextField.textFieldInterface('<mp3>loading tract 1</mp3>', 300, 22, false, 0xFFFFFF, false, false);
			theTextField = theCDynamicTextField.getTheTextField();
			theTitleTextHolder.addChild(theTextField);
		}
		private function firstTractLoaded ():void {
			trace(" ::::::::::: TitleText.firstTractLoaded() ");
		}
		/**
		 * Method for updateing the mp3 title text field.
		 */
		private function theTitleText (currentTrack:String):void {
			TweenMax.to(theTextField, .1, {alpha:0});
			currentTrackLoader = LoaderMax.getLoader(currentTrack);
			var theMP3Title:String = currentTrackLoader.vars.mp3Title;
			var rawMP3Title:XML = currentTrackLoader.vars.rawXML;
			theCDynamicTextField.updateTheTextField(rawMP3Title.mp3Title);
			TweenMax.to(theTextField, .5, {alpha:1});
			trace(" ::::::::::: MusicPlayerState.theButtonText(nodeName) " + theMP3Title + '\n' + currentTrack);
		}
	}
}
