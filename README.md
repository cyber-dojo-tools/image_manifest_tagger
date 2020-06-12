
# image_manifest_tagger

The [cyber-dojo-languages](https://github.com/cyber-dojo-languages) github org holds repos such as
[java-junit](https://github.com/cyber-dojo-languages/java-junit)
which each have two dirs, `docker/` and `start_point/`.  

The build script for each repo builds a docker image from the `docker/`
dir using the `image_builder/image_build_test_push_notify.sh` script.
This docker image is tagged with the 1st seven chars of the git commit sha of HEAD (on master)
of the git repo. For example, `cyberdojofoundation/java_junit:def84a4`

To test this tagged image we need to create a start-point image from the `start_point/`
dir where has the `image_name` inside `start_point/manifest.json` is tagged with `def84a4` so
it refers to the image built from the `docker/` dir.
    For example:
    ```json
    {
      "image_name": "cyberdojofoundation/java_junit",
      ...
    }
    ```
    becomes:
    ```json
    {
      "image_name": "cyberdojofoundation/java_junit:def84a4",
      ...
    }
    ```
The creation of this start-point image (with its modified `manifest.json`) is done by the command  
`$ cyber-dojo start-point build NAME --languages <url>...`  
which uses `image_manifest_tagger` to make this alteration.
