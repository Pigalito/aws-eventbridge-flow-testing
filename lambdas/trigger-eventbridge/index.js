const aws = require('aws-sdk');

exports.handler = async (event, context, cb) => {
    console.log(event);
    
    // Get events you want to pass into eventbridge

    const eventbridge = new aws.EventBridge();

    const arn = context.invoked_function_arn;
    const eventBusName = process.env.event_bus_name;

    const date = new Date();
    
    var params = {
      Entries: [
        {
          Detail: JSON.stringify({
              booleanVal: (date.getTime()) % 2 === 1
          }),
          DetailType: "Event triggered from dedicated lambda",
          EventBusName: eventBusName,
          Time: date,
          Resources: [arn],
          // Source is required but not authorised to use 'aws.lambda' so 'com.business' it is!
          Source: 'com.business'
        }
      ]
    };
    
    try {
      const response = await eventbridge.putEvents(params).promise();
      console.log(response);
      cb(undefined, response);
    } catch (err) {
      console.log(err, err.stack);
      cb(err);
    }
};