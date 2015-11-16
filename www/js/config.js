// Generated by CoffeeScript 1.10.0
window.logged_in_user = null;

window.myApp = angular.module('myApp', ['ngRoute', 'ngAnimate']);

myApp.config(function($routeProvider) {
  return $routeProvider.when('/', {
    controller: 'login_controller',
    templateUrl: 'views/login.html'
  }).when('/register', {
    controller: 'register_controller',
    templateUrl: 'views/register.html'
  }).when('/user', {
    controller: 'users_controller',
    templateUrl: 'views/user'
  });
});

angular.module('myApp.controllers', []);

myApp.constant('RESOURCES', (function() {
  var url;
  url = 'http://localhost:1337';
  return {
    DOMAIN: url
  };
})());

myApp.controller('users_controller', function($scope, $http, $location, RESOURCES) {});

myApp.controller('register_controller', function($scope, $http, $location, RESOURCES) {
  return $scope.register_submit = function() {
    $http.post(RESOURCES.DOMAIN + "/auth/signup", $scope.register_form_data).success(function(data) {
      var logged_in_user;
      $('.register_error').css('display', 'none');
      $scope.register_form_data = {};
      $scope.returned = data;
      logged_in_user = data;
      console.log("user " + JSON.stringify(logged_in_user));
      $location.path = '/user';
    }).error(function(err) {
      $('.register_error').show('slide', {
        direction: 'right'
      }, 1000);
      console.log("error!!!!!" + JSON.stringify(err));
      console.log("error!!!!!" + JSON.stringify(err.invalidAttributes.email[0].message));
      $scope.errorMessage = err;
    });
  };
});

myApp.controller('login_controller', function($scope, $http, $location, RESOURCES) {
  console.log('login conteroller');
  $scope.user = {};
  return $scope.login_submit = function() {
    $('.login_error').css('display', 'none');
    $http.post(RESOURCES.DOMAIN + "/auth/signin", $scope.login_form_data).success(function(data) {
      var logged_in_user;
      $scope.login_form_data = {};
      $scope.returned = data;
      logged_in_user = data;
      console.log("user " + JSON.stringify(logged_in_user));
      $location.path = '/user';
    }).error(function(err) {
      $('.login_error').show('slide', {
        direction: 'right'
      }, 1000);
      $scope.errorMessage = err;
      console.log("error!!!!!" + JSON.stringify(err));
    });
  };
});

$(document).ready(function() {});
