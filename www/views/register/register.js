// Generated by CoffeeScript 1.10.0
window.myApp.controller('register_controller', function($scope, $http, $location, RESOURCES) {
  return $scope.register_submit = function() {
    $http.post(RESOURCES.DOMAIN + "/auth/signup", $scope.register_form_data).success(function(data) {
      var logged_in_user;
      $('.register_error').css('display', 'none');
      $scope.register_form_data = {};
      $scope.returned = data;
      logged_in_user = data;
      console.log("user created " + JSON.stringify(logged_in_user));
      window.localStorage.setItem('user_jwt', JSON.stringify(logged_in_user));
      $location.path('/user');
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
