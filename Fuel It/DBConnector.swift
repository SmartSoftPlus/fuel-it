//
//  DBConnector.swift
//  Fuel It
//
//  Created by Jakub Chojak on 12/03/2022.
//

import PostgresNIO
import NIOPosix
import Logging

class DBConnector {
    func connectDataBase() async {
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let logger = Logger(label: "postgres-logger")

        let config = PostgresConnection.Configuration(connection: .init(host: "192.168.0.87", port: 5432), authentication: .init(username: "jakubchojak", database: "FuelIT", password: ""), tls: .disable)


        let connection = try! await PostgresConnection.connect(
            on: eventLoopGroup.next(),
            configuration: config,
            id: 1,
          logger: logger
        )

        try! await connection.close()

        try! eventLoopGroup.syncShutdownGracefully()
    }
}


