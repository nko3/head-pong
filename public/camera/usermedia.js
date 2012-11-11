// Generated by CoffeeScript 1.3.3
(function() {
  var URL, fallback, getUserMedia, hasGetUserMedia, init_camera, not_supported, process, show_msg, _stream, _video;

  _video = _stream = null;

  URL = window.URL || window.webkitURL;

  hasGetUserMedia = function() {
    return navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
  };

  getUserMedia = function(options, success, error) {
    getUserMedia = navigator.getUserMedia || navigator.mozGetUserMedia || navigator.webkitGetUserMedia || function(options, success, error) {
      return error();
    };
    return getUserMedia.call(navigator, options, success, error);
  };

  $("#camerabutton").on("click", function() {
    return init_camera();
  });

  $("#stopbutton").on("click", function() {
    _video.get(0).pause();
    return _stream.stop();
  });

  process = function(stream) {
    _video = $("#camvideo");
    _video.attr("src", URL.createObjectURL(stream));
    return _stream = stream;
  };

  fallback = function(e) {
    alert("err: " + e);
    return show_msg("Not able to connect with your camera device, did you authorized us?");
  };

  not_supported = function() {
    return alert("We're using cool stuff, so you need to move to a decent browser, like Chrome.");
  };

  show_msg = function(message) {
    return $("#message").html(message);
  };

  init_camera = function() {
    _stream = null;
    return getUserMedia({
      video: true,
      audio: false
    }, function(mediaStream) {
      return process(mediaStream);
    }, function(error) {
      return fallback(error);
    });
  };

  if (!hasGetUserMedia()) {
    not_supported;

  }

  init_camera();

}).call(this);
