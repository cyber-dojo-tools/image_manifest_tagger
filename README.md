
# image_manifest_tagger

The [cyber-dojo-languages](https://github.com/cyber-dojo-languages) github org holds repos such as
[java-junit](https://github.com/cyber-dojo-languages/java-junit)
which each have two dirs, `docker/` and `start_point/`.  

We need to build and publish a tagged language-test-framework image
  * from the `docker/` dir, eg `cyberdojofoundation/java_junit:def84a4`

To test this tagged image we need to create a start-point image:
  * from the `start_point/` dir
    where has the `image_name` inside `start_point/manifest.json`
    is tagged to match the first image (`def84a4`).
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


The tag is the 1st seven chars of the git commit sha of HEAD (on master) of the git repo.

Tagging the first image is straight forward.  
The image has already been built for the test.  
We simply tag it and push it to dockerhub.  

Creating the second image is trickier.  
We need to append the tag (`def84a4`) to the `image_name` property of `start_point/manifest.json`.  
This tag cannot be in the `start_point/manifest.json` file already.
There is a chicken and egg situation;
you cannot know the commit SHA until *after* you have committed).
So, on a CI run, we have to alter `start_point/manifest.json` file *in-place* (before building an image from it).
That is what this tool does.
