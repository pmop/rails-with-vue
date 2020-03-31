<template>
<body class='bg-gray-100'>
	<!-- mobile first -->
	<div class='grid grid-cols-1 lg:grid-cols-2'>
		<div class='bg-blue-800 lg:min-h-screen
			lg:flex lg:items-center p-8 sm:p-12'>
			<div class='flex-grow'>
				<h1 class='text-white text-center text-2xl sm:text-5xl mb-2'>
					Hello There!</h1>
				<p class='text-center text-white sm:text-lg'>Please, login to start.</p>
			</div>
		</div>
		<div class='lg:min-h=screen lg:flex lg:items-center p-12 lg:p-24 xl:p-48'>
			<div class='flex-grow bg-white shadow-lg rounded-md border border-gray-300 p-8'>
			<form class='flex-col w-full mt-8' @submit.prevent='signin'>

				<input class='flex-1 w-full mt-4 input-default' type='text' id='email' name='email'
				placeholder='Email' v-model='email'>

				<input class='flex-1 w-full mt-4 input-default'
				type='password' id='password' name='password'
				placeholder='Password' v-model='password'>

				<button type='submit' class='flex-shrink-0 btn btn-blue mt-4'>
					Sign In
				</button>
			</form>
			</div>
		</div>
	</div>
</body>
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
