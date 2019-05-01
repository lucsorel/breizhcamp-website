def format_talks_data:
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
            video_url: .video_url,  
            files_url: .files_url,  
            slides_url: .slides_url,
            description: .description
        };

[ .[] | format_talks_data ]
