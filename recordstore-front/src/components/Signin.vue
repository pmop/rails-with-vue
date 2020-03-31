<style>
	.flex-center {
		display: flex;
		justify-content: space-around;
	}
	.col-mode {
		display: flex;
		flex-direction: column;
	}
	.btn-sized {
		width: 300px;
		height: 48px;
	}
	.btn-primary-color {
		background-color: lightgreen;
		border-color: green;
		color: green;
	}
	.border {
		border: 1px solid lightgrey;
		border-radius: 5pt;
	}
	input {
		height: 28pt;
		margin-top: 1em;
		color: grey;
	}
</style>
<template>
<section style='padding-top: 100px; height: 50vh; width: auto;' class='flex-center'>
	<form class='border col-mode' @submit.prevent='signin' style=' height: 300px; width: 400px; justify-content: stretch; margin: 20px; padding: 40px; border: 1px solid lightgray;'>
		<input class='border' id="email" type="email" placeholder="your@email.com">
		<input class='border' id="password" type="password">
		<input class='btn-sized btn-primary-color' type='submit' value='Sign in' style='align-self: center; margin-top: 100px;'>
	</form>
</section>
</template>

<script>
export default {
  name: 'Signin',
  data () {
    return {
      email: '',
      password: '',
      error: ''
    }
  },
  created () {
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  methods: {
    signin () {
      this.$http.plain.post('/signin', { email: this.email,
			password: this.password })
        .then(response => this.signinSuccessful(response))
        .catch(error => this.signinFailed(error))
    },
    signinSuccessful (response) {
      if (!response.data.csrf) {
        this.signinFailed(response)
        return
      }

      localStorage.csrf = response.data.csrf
      localStorage.signIn = true
      this.error = ''
      this.$router.replace('/records')
    },
    signinFailed (error) {
      this.error = (error.response && error.response.data &&
			error.response.data.error) || ''
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/records')
      }
    }
  }

}
</script>
