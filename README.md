
# image_manifest_tagger

The [cyber-dojo-languages](https://github.com/cyber-dojo-languages) github org holds repos such as
[java-junit](https://github.com/cyber-dojo-languages/java-junit)
which each have two dirs, `docker/` and `start_point/`.  
If the automated tests all pass then we need to publish two tagged images:
  * one for java-junit (from `docker/`) eg
    `cyberdojofoundation/java_junit:def84a4`
  * one for the java-junit start-point (from `start_point/`) eg
    `cyberdojostartpoints/java_junit:def84a4`


We need both images to have the *same* tag (`def84a4` in the example above).  
The tag is the 1st seven chars of the git commit HEAD (on master).

Tagging the first image is straight forward.  
The image has already been built for the test.  
We simply tag it and push it to dockerhub.  

Creating the second image is trickier.  
We need to append the tag (`def84a4`) to the `image_name` property of `start_point/manifest.json`.  
For example:
```json
{
  "image_name": "cyberdojofoundation/gcc_assert",
  ...
}
```
becomes:
```json
{
  "image_name": "cyberdojofoundation/gcc_assert:def84a4",
  ...
}
```
This tag cannot be in the `start_point/manifest.json` file already.
There is a chicken and egg situation;
you cannot know the commit SHA until *after* you have committed).
So, on a CI run, we have to alter `start_point/manifest.json` file *in-place* (before building an image from it).
That is what this tool does.
