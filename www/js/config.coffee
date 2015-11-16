window.logged_in_user = null

window.myApp = angular.module('myApp', ['ngRoute', 'ngAnimate'])
myApp.config ($routeProvider) ->
  $routeProvider.when('/',
    controller: 'login_controller'
    templateUrl: 'views/login.html').when('/register',
    controller: 'register_controller',
    templateUrl: 'views/register.html').when('/user',
    controller: 'users_controller', 
    templateUrl: 'views/user')


angular.module('myApp.controllers', [])


myApp.constant 'RESOURCES', do ->
  # Define your variable
  url = 'http://localhost:1337'
  # Use the variable in your constants
  {
    DOMAIN: url
    # USERS_API: resource + '/users'
    # BASIC_INFO: resource + '/api/info'
  }

myApp.controller 'users_controller', ($scope, $http, $location, RESOURCES) ->



myApp.controller 'register_controller', ($scope, $http, $location, RESOURCES) ->
  
  $scope.register_submit = ->
    
    $http.post("#{RESOURCES.DOMAIN}/auth/signup", $scope.register_form_data).success((data) ->
      $('.register_error').css 'display', 'none' #remove error message if it's there
      
      $scope.register_form_data = {}
      $scope.returned = data
      logged_in_user = data
      console.log "user " + JSON.stringify logged_in_user
      $location.path = '/user'
      return
    ).error (err) ->
      $('.register_error').show 'slide', { direction: 'right' }, 1000
      console.log "error!!!!!" + JSON.stringify err
      console.log "error!!!!!" + JSON.stringify err.invalidAttributes.email[0].message
      $scope.errorMessage = err
      return
    return

myApp.controller 'login_controller', ($scope, $http, $location, RESOURCES) ->
  console.log 'login conteroller'
  $scope.user = {}
  
  $scope.login_submit = ->

    # $('.login_error').hide 'slide', { direction: 'left' }, 1000 #remove error message if it's there
    $('.login_error').css 'display', 'none' #remove error message if it's there

    $http.post("#{RESOURCES.DOMAIN}/auth/signin", $scope.login_form_data).success((data) ->

      # $location.path '/register'

      $scope.login_form_data = {}
      $scope.returned = data
      logged_in_user = data
      
      
      console.log "user " + JSON.stringify logged_in_user
      $location.path = '/user'
      return
    ).error (err) ->
      $('.login_error').show 'slide', { direction: 'right' }, 1000
      $scope.errorMessage = err
      console.log "error!!!!!" + JSON.stringify err
      return
    return






  # init()
  # return
$(document).ready ->

  


  


  #
  
  