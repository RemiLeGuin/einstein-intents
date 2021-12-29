public class EinsteinIntents {
    public Intent[] intents;
    public class Intent {
        public Decimal probability;
        public String label;
    }
}

/*
{
    "probabilities": [
        {
            "probability": 0.9909142,
            "label": "Change Payment Date"
        },
        {
            "probability": 0.006347644,
            "label": "Request Refund"
        },
        {
            "probability": 0.0024158075,
            "label": "Name Change"
        },
        {
            "probability": 2.2067025E-4,
            "label": "General Enquiry"
        },
        {
            "probability": 5.879208E-5,
            "label": "Early Settlement Requests"
        }
    ]
}
*/