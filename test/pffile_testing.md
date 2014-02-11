# PFFile Testing

Running the full test suite requires that you pre-seed the remote Parse account with test data in order to workound some issues with the way Parse and the Parse iOS SDK treats file uploads.

## Setup / Teardown
In order to run the tests, you first need to seed the database.  Run the following:

```sh
cd test && bundle install
PARSE_APP_ID=<parse_app_id> PARSE_REST_KEY=<parse_rest_key> bundle exec rake setup
```

That will create 20 `Profile` objects, each with an associated PFFile under the `"signature"` key.

At this point, tests should run successfully.  Keep in mind that each test will delete the `Profile` PFObject that it used.  If you run low on `Profile` objects, just re-run the setup Rake task above.

If you'd like to clean up after testing, run the following:

```sh
PARSE_APP_ID=<parse_app_id> PARSE_REST_KEY=<parse_rest_key> bundle exec rake teardown
```

Keep in mind that in order to permanently remove the testing files from your account, you'll need to do so via the "Clean Up Files" section of Parse's Settings Page.

## Background

So, why is all this necessary?  The Parse SDK has the following characteristics regarding PFFiles:

* PFFiles are assigned a unique identifier upon creation, and that unique identifier is used to cache the file on disk.  The identifier is static and cannot be changed.
* When a PFFile is saved (uploaded), the file data is _also_ cached on disk.  A subsequent call to fetch the data will raise an exception since the SDK considers the data present.
* It doesn't seem possible to clear the SDK's file cache (ala `+[PFQuery clearAllCachedResults]`)

Together, these characteristics prevent the tests from creating and fetching PFFile objects within the same testing execution.