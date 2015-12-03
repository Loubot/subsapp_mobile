window.myApp.controller 'register_controller', ($scope, $http, $location, RESOURCES) ->
  
  $scope.register_submit = ->
    $scope.register_form_data.is_admin = false
    $http.post("#{RESOURCES.DOMAIN}/auth/signup", $scope.register_form_data).success((data) ->
      $('.register_error').css 'display', 'none' #remove error message if it's there
      
      $scope.register_form_data = {}
      
      $scope.returned = data
      logged_in_user = data
      console.log "user created " + JSON.stringify logged_in_user.data
      window.localStorage.setItem 'user_jwt', JSON.stringify(logged_in_user.data)
      $location.path '/user'
      return
    ).error (err) ->
      $('.register_error').show 'slide', { direction: 'right' }, 1000
      console.log "error!!!!!" + JSON.stringify err
      console.log "error!!!!!" + JSON.stringify err.invalidAttributes.email[0].message
      $scope.errorMessage = err
      return
    return