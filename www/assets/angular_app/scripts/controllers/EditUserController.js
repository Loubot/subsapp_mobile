// Generated by CoffeeScript 1.10.0
'use strict';
angular.module('subzapp_mobile').controller('EditUserController', [
  '$scope', '$state', '$http', '$window', 'message', 'user', 'RESOURCES', function($scope, $state, $http, $window, message, user, RESOURCES) {
    var stripeResponseHandler, user_token;
    console.log('User Controller');
    console.log('User Controller');
    user_token = window.localStorage.getItem('user_token');
    if (!(window.USER != null)) {
      user.get_user().then((function(res) {
        $scope.orgs = window.USER.orgs;
        return $scope.user = USER;
      }), function(errResponse) {
        console.log("User get error " + (JSON.stringify(errResponse)));
        window.USER = null;
        return $state.go('login');
      });
    } else {
      console.log('else');
      $scope.orgs = window.USER.orgs;
      $scope.user = USER;
    }
    stripeResponseHandler = function(status, response) {
      console.log(status);
      return console.log(response);
    };
    Stripe.setPublishableKey('pk_test_bfa4lYmoaJZTm9d94qBTEEra');
    $('#payment-form').submit(function(event) {
      var $form;
      console.log(Stripe);
      event.preventDefault();
      $form = $(this);
      $form.find('button').prop('disabled', true);
      Stripe.card.createToken($form, stripeResponseHandler);
      return false;
    });
    return $scope.edit_user = function() {
      return $http({
        method: 'POST',
        url: RESOURCES.DOMAIN + "/edit-user",
        headers: {
          'Authorization': "JWT " + user_token,
          "Content-Type": "application/json"
        },
        data: {
          id: $scope.user.id,
          firstName: $scope.user.firstName,
          lastName: $scope.user.lastName
        }
      }).then((function(response) {
        console.log("Edit user response " + (JSON.stringify(response)));
        return message.success('User updated ok');
      }), function(errResponse) {
        console.log("Edit user error " + (JSON.stringify(errResponse)));
        return message.errir(JSON.stringify(errResponse));
      });
    };
  }
]);
