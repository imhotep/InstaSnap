/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
var app = {
    clean: false,
    // Application Constructor
    initialize: function() {
        this.bindEvents();
    },
    // Bind Event Listeners
    //
    // Bind any events that are required on startup. Common events are:
    // 'load', 'deviceready', 'offline', and 'online'.
    bindEvents: function() {
        document.addEventListener('deviceready', this.onDeviceReady, false);
    },
    // deviceready Event Handler
    //
    // The scope of 'this' is the event. In order to call the 'receivedEvent'
    // function, we must explicitly call 'app.receivedEvent(...);'
    onDeviceReady: function() {
        app.receivedEvent('deviceready');
    },
    // Update DOM on a Received Event
    receivedEvent: function(id) {
        var parentElement = document.getElementById(id);
        var listeningElement = parentElement.querySelector('.listening');
        var receivedElement = parentElement.querySelector('.received');

        listeningElement.setAttribute('style', 'display:none;');
        receivedElement.setAttribute('style', 'display:block;');

        console.log('Received Event: ' + id);
        
        
        var captureNowBtn = document.getElementById("captureNowBtn");
        captureNowBtn.addEventListener('click', this.captureNow);
    },
    captureNow: function() {
        console.log("JS::captureNow");
        var win = function(r) {

            if(app.clean === false) {
                // deleting deviceready
                var deviceready = document.getElementById("deviceready");
                var drp = deviceready.parentElement;
                drp.removeChild(deviceready);

                // changing app css a bit
                var appCss = document.getElementsByClassName("app")[0];
                appCss.style.top = "25%";
                appCss.style.background = "none";

                // deleting title
                var h1 = document.getElementsByTagName("h1")[0];
                var parentH1 = h1.parentElement;
                parentH1.removeChild(h1);

                app.clean = true;
            }
            
            var myPic = document.getElementById("myPic");
            myPic.src = "data:image/jpeg;base64,"+r;
        };
        
        var fail = function(e) {
            console.log("An error occurred", e.message)
        };
        cordova.exec(win, fail, 'MyCamera', 'captureNow', []);
    },
    surprise: function() {
        var filters = ["grayscale", "blur", "saturate", "sepia", "invert", "brightness", "contrast", "opacity"];
        var imageSection = document.getElementById("imageSection");

        imageSection.className = filters[Math.floor((Math.random() * 10) + 1)];
    }
};

app.initialize();
