package flash.net;

@:final @:require(flash10_1) extern class NetStreamMulticastInfo {
	var new(require flash10_1,require flash10_1) : Float -> Float -> Float -> Float -> Float -> Float -> Float -> Float -> Float -> Float -> Float -> Float -> Float -> Float -> Float -> Float -> Float -> Float -> Float -> Void;
	var bytesPushedFromPeers(default,null) : Float;
	var bytesPushedToPeers(default,null) : Float;
	var bytesReceivedFromIPMulticast(default,null) : Float;
	var bytesReceivedFromServer(default,null) : Float;
	var bytesRequestedByPeers(default,null) : Float;
	var bytesRequestedFromPeers(default,null) : Float;
	var fragmentsPushedFromPeers(default,null) : Float;
	var fragmentsPushedToPeers(default,null) : Float;
	var fragmentsReceivedFromIPMulticast(default,null) : Float;
	var fragmentsReceivedFromServer(default,null) : Float;
	var fragmentsRequestedByPeers(default,null) : Float;
	var fragmentsRequestedFromPeers(default,null) : Float;
	var receiveControlBytesPerSecond(default,null) : Float;
	var receiveDataBytesPerSecond(default,null) : Float;
	var receiveDataBytesPerSecondFromIPMulticast(default,null) : Float;
	var receiveDataBytesPerSecondFromServer(default,null) : Float;
	var sendControlBytesPerSecond(default,null) : Float;
	var sendControlBytesPerSecondToServer(default,null) : Float;
	var sendDataBytesPerSecond(default,null) : Float;
	function toString() : String;
}
