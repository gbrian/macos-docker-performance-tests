# macos Docker perfomance tests
A set of tests to help finding macos Docker Desktop performance issues


# Docker desktop settings
`group.com.docker` contains the different settings tested

Install diff utils: 
```
brew install diffutils
````

> docker settings:
`~/Library/Group\ Containers/group.com.docker/settings.json`

## how it works
Script will look at the test folder for the `setup.sh` file. Usually this will prepare the necessary dependencies and build docker image for the test.

Then the script will execute N times `local.sh` and `docker.sh` scripts and take the time taken.

At the end you will have an output like this:

````
Benchmarking example
   Run setup
Buiding docker image: docker-test:example
[+] Building 2.3s (10/10) FINISHED                                                                                                                                                                         
 => [internal] load build definition from Dockerfile.base                                                                                                                                             0.3s
 => => transferring dockerfile: 42B                                                                                                                                                                   0.0s
 => [internal] load .dockerignore                                                                                                                                                                     0.5s
 => => transferring context: 2B                                                                                                                                                                       0.0s
 => [internal] load metadata for docker.io/library/node:17                                                                                                                                            0.8s
 => [1/5] FROM docker.io/library/node:17@sha256:13621aa823b6b92572d19c08a75f7b1a061633089f37873f8b5bedb5e900e657                                                                                      0.0s
 => [internal] load build context                                                                                                                                                                     0.2s
 => => transferring context: 142B                                                                                                                                                                     0.0s
 => CACHED [2/5] RUN mkdir /src                                                                                                                                                                       0.0s
 => CACHED [3/5] WORKDIR /src                                                                                                                                                                         0.0s
 => CACHED [4/5] COPY . /src                                                                                                                                                                          0.0s
 => CACHED [5/5] RUN chmod +x /src/entrypoint.sh                                                                                                                                                      0.0s
 => exporting to image                                                                                                                                                                                0.5s
 => => exporting layers                                                                                                                                                                               0.0s
 => => writing image sha256:d6f7e4cc9289550125c162adf89ba4140c3d9b8a49adaf336d2179344c9542bc                                                                                                          0.0s
 => => naming to docker.io/library/docker-test:example                                                                                                                                                0.0s

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
   Test iteration 1
      Run A
v17.2.0
1.22.15
Local execution
v17.2.0
1.22.17
       Run B
Docker execution
v17.2.0
1.22.15
       A vs B: 3 - 3
Benchmark <example> local vs docker
 3 - 3
 3 - 2
````


## Usage

`$ ./test.sh example 1 --verbose`

### Where
* test.sh Runs the tests
* example Folder with the test
* 1 Number of iterations
* --verbose Optional. Verbose output

## Output


## Test folder
Contains each test
* .env Env file :)
* setup.sh Test setup. Executed only once at the beginning, does not affect to timing.
* local.sh  Runs the test on macos
* docker.sh Runs the test on docker
* entrypoint.sh Contains the test case

## Global files
* /fncs.sh Support functions
* /test.sh Runs tests
* /ubuntu-docker.sh Utils to install docker on ubuntu cloud instance
* /tests/Dockerfile.base Base docker file for tests


