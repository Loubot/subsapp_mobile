// Generated by CoffeeScript 1.10.0
'use strict';
angular.module('subzapp_mobile').controller('LoginController', [
  '$scope', '$state', '$http', '$window', 'message', 'RESOURCES', function($scope, $state, $http, $window, message, RESOURCES) {
    console.log('Login Controller');
    console.log('login conteroller');
    $scope.user = {};
    return $scope.login_submit = function() {
      $('.login_error').css('display', 'none');
      $http.post(RESOURCES.DOMAIN + "/auth/signin", $scope.login_form_data).success(function(data) {
        window.localStorage.setItem('user_token', data.token);
        window.localStorage.setItem('user_id', data.user.id);
        $state.go('user');
      }).error(function(err) {
        $('.login_error').show('slide', {
          direction: 'right'
        }, 1000);
        $scope.errorMessage = err;
        console.log("error!!!!!" + JSON.stringify(err));
      });
    };
  }
]);
