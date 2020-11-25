const aws = require('aws-sdk');

exports.handler = async (event, context, cb) => {
    console.log(event);
    
    // Get events you want to pass into eventbridge

    const eventbridge = new aws.EventBridge();

    const arn = context.invoked_function_arn;
    const eventBusName = process.env.event_bus_name;
    
    var params = {
      Entries: [
        {
          Detail: JSON.stringify({
              loyalty: (new Date().getTime()) % 2 === 1
          }),
          DetailType: "Event triggered from dedicated lambda",
          EventBusName: eventBusName,
          Time: new Date(),
          Resources: [arn]
        }
      ]
    };
    
    await new Promise((resolve, reject) => {
        eventbridge.putEvents(params, function(err, data) {
            if (err) {
              console.log(err, err.stack);
              cb(err);
            } else {
              console.log(data);
              cb(undefined, data);
            }
        });
    });
};