`<%-- 
    Document   : newjsp
    Created on : Feb 24, 2018, 10:06:25 AM
    Author     : Arwa
9/3/2018
--%>

<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--<link rel="stylesheet" href="Entry.css">-->

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>

            .navbar input[type=text] {
                float: left;
                padding: 6px;
                margin-top: 8px;
                font-size: 17px;
                border: solid 1px #ffcccc;
                width: 170px;
            }
            .navbar .search-container button {
                float: left;
                padding: 6px 10px;
                margin-top: 8px;
                margin-right: 16px;
                background: #ffcccc;
                font-size: 19px;
                border: none;
                cursor: pointer;
            }

            .navbar .search-container button:hover {
                background: #ff9a9d;
            }

            /*    #search
            {
                float: right;
              padding: 6px 10px;
              margin-top: 8px;
              margin-right: 16px;
              background: #ffcccc;
              font-size: 19px;
              border: none;
              cursor: pointer; 
            }*/
            /*search-container
            {
             float: right;
              padding: 6px 10px;
              margin-top: 8px;
              margin-right: 16px;
              background: #ffcccc;
              font-size: 19px;
              border: none;
              cursor: pointer;
            }*/
            .navbar{
                overflow: hidden;
                padding: 6px;
                background-color: black;
                font-family: Arial, Helvetica, sans-serif;
            }

            .navbar a {
                font-style: italic;
                float: left;
                font-size: 22px;
                color: #ffcccc;
                text-align: center;
                padding: 14px 16px;
                text-decoration: none;
            }
            h1{
                float: left;
                font-size: 22px;
                color: #ffcccc;
                font-style:italic ;

            }

            .dropdown {
                float: left;
                overflow: hidden;
            }

            .dropdown .dropbtn {
                cursor: pointer;
                font-size: 22px;    
                border: none;
                outline: none;
                color: #ffcccc;
                padding: 14px 16px;
                background-color: inherit;
                font-family: inherit;
                margin: 0;
            }

            .navbar a:hover, .dropdown:hover .dropbtn, .dropbtn:focus {
                /*background-color: #ddd;*/
                border: solid 1px #ffcccc;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                /*background-color: #ddd;*/
                min-width: 160px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
            }

            .dropdown-content a {
                float: none;
                color: #ffcccc;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
                text-align: left;
            }

            .dropdown-content a:hover {
                /*background-color: #ddd;*/
            }

            .show {
                display: block;
            }
            header, footer {
                padding: 1em;
                color: #ffcccc;
                background-color: white;
                clear: left;
                text-align: center;
                font-size: 22px;
            }
            html,body {
                margin: 0;
                padding: 0;
            }
            .slider {
                /*width: 1200px;*/
                width: 550px;
                margin: 2em auto;

            }

            .slider-wrapper {

                width: 100%;
                height: 450px;
                position: relative;
                align-self: center;
            }

            .slide {
                align-self: center;
                float: left;
                position: absolute;
                width: 100%;
                height: 100%;
                opacity: 0;
                transition: opacity 3s linear;
            }

            .slider-wrapper > .slide:first-child {
                opacity: 1;
            }


        </style>
    </head>

    <body>
        <div class="navbar" style="background-color: #000000;text-align: center" >
            <h1 >Souq &MediumSpace;&MediumSpace;&MediumSpace;&MediumSpace;&MediumSpace;&MediumSpace;</h1>
            <a href="loginpage.html">Login</a>
            <a href="SignUp.html">SignUP</a>
            <div class="dropdown">
                <button class="dropbtn" onclick="myFunction()">Category
                    <i class="fa fa-caret-down"></i>
                </button>
                <div class="dropdown-content" id="myDropdown">
                    <a href="MobileCategory.jsp">Mobiles</a>
                    <a href="#">Laptops</a>
                    <!--<a href="#">Link 3</a>-->
                </div>
            </div> 
            <div class="search-container">
                <form action="MobileCategory.jsp">
                    <input type="text" placeholder="Search.." name="search">
                    <button id="search" type="submit"><i class="fa fa-search"></i></button>
                </form>
            </div>
        </div>

        <div class="slider" id="main-slider"><!-- outermost container element -->
            <div class="slider-wrapper"><!-- innermost wrapper element -->


                <img src="1.jpg" alt="First" class="slide"/>
                <img src="htc10.jpg" alt="Second" class="slide" />
                <img src="infinix.jpg" alt="Third" class="slide" />
            </div>

        </div>	
        <%
            String keyWord = request.getParameter("search");
            if (keyWord != null) {
               if(keyWord.equals("mobiles"))
               {
                   response.sendRedirect("MobileCategory.jsp");
               }else
               {
                   
               }
            }
        %>
        <script>
            (function () {

                function Slideshow(element) {
                    this.el = document.querySelector(element);
                    this.init();
                }

                Slideshow.prototype = {
                    init: function () {
                        this.wrapper = this.el.querySelector(".slider-wrapper");
                        this.slides = this.el.querySelectorAll(".slide");
                        this.previous = this.el.querySelector(".slider-previous");
                        this.next = this.el.querySelector(".slider-next");
                        this.index = 0;
                        this.total = this.slides.length;
                        this.timer = null;

                        this.action();
                        this.stopStart();
                    },
                    _slideTo: function (slide) {
                        var currentSlide = this.slides[slide];
                        currentSlide.style.opacity = 1;

                        for (var i = 0; i < this.slides.length; i++) {
                            var slide = this.slides[i];
                            if (slide !== currentSlide) {
                                slide.style.opacity = 0;
                            }
                        }
                    },
                    action: function () {
                        var self = this;
                        self.timer = setInterval(function () {
                            self.index++;
                            if (self.index == self.slides.length) {
                                self.index = 0;
                            }
                            self._slideTo(self.index);

                        }, 2500);
                    },
                    stopStart: function () {
                        var self = this;
                        self.el.addEventListener("mouseover", function () {
                            clearInterval(self.timer);
                            self.timer = null;

                        }, false);
                        self.el.addEventListener("mouseout", function () {
                            self.action();

                        }, false);
                    }


                };

                document.addEventListener("DOMContentLoaded", function () {

                    var slider = new Slideshow("#main-slider");

                });


            })();

        </script>
        <footer>Copyright &copy; MiniSouq.com</footer>

        <!--<h3>Dropdown Menu inside a Navigation Bar</h3>-->
        <!--<p>Click on the "Dropdown" link to see the dropdown menu.</p>-->

        <script>
            /* When the user clicks on the button, 
             toggle between hiding and showing the dropdown content */
            function myFunction() {
                document.getElementById("myDropdown").classList.toggle("show");
            }

            // Close the dropdown if the user clicks outside of it
            window.onclick = function (e) {
                if (!e.target.matches('.dropbtn')) {
                    var myDropdown = document.getElementById("myDropdown");
                    if (myDropdown.classList.contains('show')) {
                        myDropdown.classList.remove('show');
                    }
                }
            }
        </script>
    </body>
</html>
