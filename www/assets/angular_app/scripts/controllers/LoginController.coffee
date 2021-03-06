'use strict'

angular.module('subzapp_mobile').controller('LoginController', [
  '$scope'
  '$state'
  '$http'
  '$window'
  'message'
  'RESOURCES'
  # 'AuthService'
  ( $scope, $state, $http, $window, message, RESOURCES ) ->
    console.log 'Login Controller'

    console.log 'login conteroller'
    $scope.user = {}
    
    $scope.login_submit = ->

      # $('.login_error').hide 'slide', { direction: 'left' }, 1000 #remove error message if it's there
      $('.login_error').css 'display', 'none' #remove error message if it's there

      $http.post("#{RESOURCES.DOMAIN}/auth/signin", $scope.login_form_data).success((data) ->
        # console.log "data #{ JSON.stringify data }"
        # $location.path '/register'

        # $scope.login_form_data = {}
        # $scope.returned = data
        # logged_in_user = data
        window.localStorage.setItem 'user_token', data.token
        window.localStorage.setItem 'user_id', data.user.id
       
        $state.go 'all_org'
        return
      ).error (err) ->
        $('.login_error').show 'slide', { direction: 'right' }, 1000
        message.error err.message
        window.USER = null
        console.log "error!!!!!" + JSON.stringify err
        return
      return
])
