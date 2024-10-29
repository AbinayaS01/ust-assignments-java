function getTravelDetails(travelArray) {
    return travelArray.map(travel => {
        const {
            traveler = "Unknown Traveler",
            destination = "Unknown Destination",
            flight: {
                flightNumber = "Not Specified",
                departureTime = "Not Specified"
            } = {},
            accommodation: {
                hotel = "Not Specified",
                checkIn = "Not Specified",
                checkOut = "Not Specified"
            } = {}
        } = travel;

        if (hotel === "Not Specified" && flightNumber === "Not Specified") {
            return `${traveler} destination is ${destination}. Flight is not specified.`;
        }

        if (hotel === "Not Specified") {
            return `${traveler} is traveling to ${destination}. Flight ${flightNumber} departs at ${departureTime}.`;
        }

        return `${traveler} is traveling to ${destination}, staying at ${hotel} from ${checkIn} to ${checkOut}.`;
    });
}


const travelArray = [
    {
        traveler: "Adithya",
        destination: "Paris",
        flight: { flightNumber: "AF123", departureTime: "2024-04-30" },
        accommodation: { hotel: "Hilton", checkIn: "2024-05-01", checkOut: "2024-05-05" }
    },
    {
        traveler: "Sharath",
        destination: "Tokyo",
        flight: {}
    }
];

console.log(getTravelDetails(travelArray));
