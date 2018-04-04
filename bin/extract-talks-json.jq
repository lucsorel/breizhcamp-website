def filter_object_data:
    . | {
            id: .id,
            name: .name,
            event_start: .event_start,
            event_end: .event_end,
            event_type: .event_type,
            format: .format,
            venue: .venue,
            venue_id: .venue_id,
            speakers: .speakers | rtrimstr(", "),
            video_url: null,        # on ne prend pas .video
            files_url: null,        # on ne prend pas .media_url
            slides_url: null,       # on ne prend pas .slides
            description: .description
        };

[ .[] | filter_object_data ]
