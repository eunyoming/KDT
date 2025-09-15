package com.kedu.dto;

import lombok.*;

import java.sql.Timestamp;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoardDTO {
    private long id;
    private String title;
    private String writer;
    private String contents;
    private long viewCount;
    private Timestamp writeDate;
}
