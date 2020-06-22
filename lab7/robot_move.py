#!/usr/bin/env python

import rospy
from geometry_msgs.msg import Twist
from sensor_msgs.msg import LaserScan
#from math import pow, atan2, sqrt

class Robot:
	def __init__(self):
	        # Creates a node with name 'turtlebot_controller' and make sure it is a
		# unique node (using anonymous=True).
        	rospy.init_node('antpot', anonymous=True)

        	# Publisher which will publish to the topic '/turtle1/cmd_vel'.
        	self.velocity_publisher = rospy.Publisher('/cmd_vel', Twist, queue_size=10)

        	# A subscriber to the topic '/turtle1/pose'. self.update_pose is called
        	# when a message of type Pose is received.
        	self.pose_subscriber = rospy.Subscriber('/base_scan', LaserScan, self.update_pose)

        	self.pose = LaserScan()
        	for i in range(18):
        		self.pose.ranges.append(0)
        	self.rate = rospy.Rate(10)
		self.dist_forward=0
		self.dist_right=10
		self.dist_left=10

	def update_pose(self, data):
        	self.pose = data
		self.dist_forward=sum(self.pose.ranges[7:11])/5
		#self.dist_right=sum(self.pose.ranges[0:6])/7
		self.dist_right=self.pose.ranges[1]
		#self.dist_right=self.pose.ranges[2]
		#self.dist_left=sum(self.pose.ranges[12:18])/7
		self.dist_left=self.pose.ranges[17]
		#self.dist_right=self.pose.ranges[16]
		#right=sum(self.pose.ranges[0:6])/len(self.pose.ranges[0:6])
		#forward=sum(self.pose.ranges[6:12])/len(self.pose.ranges[6:12]
		#left=sum(self.pose.ranges[12:18])/len(self.pose.ranges[12:18])
		#self.pose.ranges = [right, forward, left]
		#print (right, forward, left)
    		#print self.pose.ranges[9]

	def move_forward(self):		
		vel_msg = Twist()
		#start filling unused fields
		vel_msg.linear.y = 0
		vel_msg.linear.z = 0
		vel_msg.angular.x = 0
		vel_msg.angular.y = 0
		#fill linear speed
		if self.dist_forward >= 5 :
			print self.dist_forward
			vel_msg.linear.x = self.dist_forward*0.3
			vel_msg.angular.z = 0
		else:
			#calculate angular speed
			if self.dist_right<self.dist_left:
				print "rotate right"
				self.angz=self.dist_right/self.dist_left
			else: 
				print "rotate left"
				self.angz=-self.dist_left/self.dist_right		
			vel_msg.linear.x = 0.5
			vel_msg.angular.z = self.angz*60
		
		
		# Publishing our vel_msg
		self.velocity_publisher.publish(vel_msg)

		
		# Publish at the desired rate.
		self.rate.sleep()

		# Stopping our robot after the movement is over.
		#vel_msg.linear.x = 0
		return
	
	def move(self):
		while not rospy.is_shutdown():
			self.move_forward()
		#self.rotate()

if __name__ == '__main__':
    try:
	x = Robot()
	x.move()
    except rospy.ROSInterruptException:
        pass
