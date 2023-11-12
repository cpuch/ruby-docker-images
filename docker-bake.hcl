# docker-bake.hcl
group "default" {
	targets = ["ruby"]
}

target "ruby" {
	/**
	 * Specify name resolution for targets that use a matrix strategy.
	 * https://docs.docker.com/build/bake/reference/#targetname
	 */
	name = "ruby${replace(version, ".", "-")}"

	/**
	 * Define the matrix strategy.
	 * https://docs.docker.com/build/bake/reference/#targetmatrix
	 */
	matrix = {
		version = ["2.3.8", "2.4.10", "2.5.9", "2.6.10", "2.7.8", "3.0.6", "3.1.4", "3.2.2"]
	}

	/**
	 * Specifies the location of the build context to use for this target
	 * https://docs.docker.com/build/bake/reference/#targetcontext
	 */
	context = "."

	/**
	 * Name of the Dockerfile to use for the build.
	 * https://docs.docker.com/build/bake/reference/#targetdockerfile
	 */
	dockerfile = "Dockerfile"

	/**
	 * Image names and tags to use for the build target.
	 * https://docs.docker.com/build/bake/reference/#targettags
	 */
	tags = ["cpuchalver/ruby:${version}"]

	/**
	 * Define build arguments for the target.
	 * https://docs.docker.com/build/bake/reference/#targetargs
	 */
	args = {
		RUBY_VERSION = version
	}

	/**
	 * Set target platforms for the build target.
	 * https://docs.docker.com/build/bake/reference/#targetplatforms
	 */
	platforms = ["linux/amd64"]

	/**
	 * Don't use cache when building the image.
	 * https://docs.docker.com/build/bake/reference/#targetno-cache
	 */
	//no-cache = true
}
