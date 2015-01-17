package flash.media;

@:final @:require(flash10_2) extern class MicrophoneEnhancedOptions {
	var new(require flash10_2,require flash10_2) : Void -> Void;
	var autoGain : Bool;
	var echoPath : Int;
	var isVoiceDetected : Int;
	var mode : MicrophoneEnhancedMode;
	var nonLinearProcessing : Bool;
}
