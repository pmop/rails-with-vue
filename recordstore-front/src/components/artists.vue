<template>
	<div class='max-w-md m-auto py-10'>
		<div class='text-red' v-if='error'>{{ error }}</div>
		<h3 class='font-mono font-regular text-3xl mb-4'>Add a new artist</h3>
		<div class='lg:min-h=screen lg:flex lg:items-center p-12 lg:p-24 xl:p-48'>
			<div class='flex-grow bg-white shadow-lg
				rounded-md border border-gray-300 p-8'>
				<form class='w-full flex-col' @submit.prevent='addArtist'>
					<input
						type='text'
						class='flex-1 w-full mt-4 input-default'
						v-model='newArtist.name'>

						<input
							type='submit'
							value='Add Artist'
							class='font-sans font-bold flex-1 mt-4 btn btn-blue'
							v-model='newArtist.name'>
				</form>
				<hr class='border border-grey-200' my-6>
				<ul class='list-reset mt-4'>
					<li class='py-4'
						v-for='artist in artists'
						:key='artist.id'
						:artist='artist'>
						<div class='flex
							items-center
							justify-between
							flex-wrap'>
							<p class='block
								flex-1
								font-mono
								font-semibold
								flex items-center'>{{ artist.name }}</p>
							<svg class="fill-current text-indigo-600" viewBox="0 0 24 24" width="24" height="24"><title>record vinyl</title><path d="M23.938 10.773a11.915 11.915 0 0 0-2.333-5.944 12.118 12.118 0 0 0-1.12-1.314A11.962 11.962 0 0 0 12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12c0-.414-.021-.823-.062-1.227zM12 16a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm0-5a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"></path>
							</svg>

								<button class="bg-transparent
									text-sm hover:bg-blue-600
									hover:text-whit1
									text-blue-600
									border-blue-600
									no-underline font-bold py-2 px-4 mr-2 rounded"
									@click.prevent='editArtist(artist)'>Edit</button>

								<button class="bg-transparent
									text-sm hover:bg-red-600
									hover:text-white
									text-red-600
									border-red-600
									no-underline font-bold py-2 px-4 mr-2 rounded"
									@click.prevent='removeArtist(artist)'>Delete</button>

								<div v-if='artist == editArtist'>
									<form @submit.prevent='updateArtist(artist)'>
										<div class='mb-6 p-4 bg-white rounded border
											border-grey-100 mt-4'>

											<input
												type='submit'
												class='font-sans font-bold flex-1 mt-4 input-default'
												v-model='artist.name'>

											<input
												type='submit'
												value='Update'
												class='font-sans font-bold flex-1 mt-4 btn btn-blue'
												v-model='newArtist.name'>

											</div>
									</form>
								</div>

						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
</template>
<script>
export default {
	name: 'Artists',
	data () {
		return {
			artists: [],
			newArtists: [],
			error: '',
			editAritst: ''
		}
	},
	created () {
		if (!localStorage.signedIn) {
			this.$router.replace('/')
		} else {
			this.$http.secured.get('/api/v1/artists')
				.then(response => {
					this.artists = response.data
				})
				.catch(error => this.setError(error, 'Something went wrong'))
		}
	},
	methods: {
		setError (error, text) {
			this.error = (error.response && error.response.data &&
				error.response.data.error) || text
		},
		addArtists () {
			const value = this.newArtist
			if (!value) {
				return
			}
			this.$http.secured.post('/api/v1/artists', { artist: { name: this.newArtist.name } })
				.then(response => {
					this.artists.push(response.data)
					this.newArtist = ''
				})
				.catch(error => this.setError(error, 'Cannot creat artist'))
		},
		removeArtist (artist) {
			this.$http.secured.delete(`/api/v1/artists/${artist.id}`)
				.then(response => {
					this.artists.splice(this.artists.indexOf(artist), 1)
				})
				.catch(error => this.setError(error, 'Cannot delete artist'))
		},
		editArtist (artist) {
			this.editArtist = artist
		},
		updateArtist (artist) {
			this.editArtist = ''
			this.$http.secured.patch(`/api/v1/artists/${artist.id}`, { artist: { title: artist.name } })
				.catch(error => {
					this.setError(error, 'Cannot update artist')
				})
		}
	}
}
</script>
